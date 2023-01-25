-- FUNCTION: public.ulubione_uzytkownika(integer)

-- DROP FUNCTION IF EXISTS public.ulubione_uzytkownika(integer);

CREATE OR REPLACE FUNCTION public.ulubione_uzytkownika(
	we_uzytkownik_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	wy_lista text;
begin
	select string_agg(q.przepis_id::text,',')
	from (select p.przepis_id::text as "przepis_id"
		from public.przepis_info p
		where p.uzytkownik_id = we_uzytkownik_id
			and p.ulubiony = true
		order by p.id desc) q
	into wy_lista;

	return wy_lista;
	
end
$BODY$;

ALTER FUNCTION public.ulubione_uzytkownika(integer)
    OWNER TO postgres;
