-- FUNCTION: public.edytuj_przepis_info(integer, integer, boolean, text)

-- DROP FUNCTION IF EXISTS public.edytuj_przepis_info(integer, integer, boolean, text);

CREATE OR REPLACE FUNCTION public.edytuj_przepis_info(
	we_uzytkownik_id integer,
	we_przepis_id integer,
	we_ulubiony boolean,
	we_notatka text)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	wew_istnieje boolean;
begin
	wew_istnieje = exists(
		select *
		from public.przepis_info pi
		where pi.uzytkownik_id = we_uzytkownik_id
			and pi.przepis_id = we_przepis_id
	);
	
	if wew_istnieje then
		update public.przepis_info
		set ulubiony = we_ulubiony,
			notatka = we_notatka
		where uzytkownik_id = we_uzytkownik_id
			and przepis_id = we_przepis_id;
	else
		insert into public.przepis_info(
			uzytkownik_id,
			przepis_id,
			ulubiony,
			notatka)
		values(
			we_uzytkownik_id,
			we_przepis_id,
			we_ulubiony,
			we_notatka);
	end if;
end
$BODY$;

ALTER FUNCTION public.edytuj_przepis_info(integer, integer, boolean, text)
    OWNER TO postgres;
