-- FUNCTION: public.sprawdz_dane_logowania(text, text)

-- DROP FUNCTION IF EXISTS public.sprawdz_dane_logowania(text, text);

CREATE OR REPLACE FUNCTION public.sprawdz_dane_logowania(
	we_login text,
	we_haslo_hash text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	wy_id integer;
begin
	select u.id
	from public.uzytkownik u
	where u.login=we_login
		and u.haslo_hash=we_haslo_hash
	limit 1
	into wy_id;
	
	return wy_id;
	
end
$BODY$;

ALTER FUNCTION public.sprawdz_dane_logowania(text, text)
    OWNER TO postgres;
