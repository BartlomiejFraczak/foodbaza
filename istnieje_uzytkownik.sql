-- FUNCTION: public.istnieje_uzytkownik(text)

-- DROP FUNCTION IF EXISTS public.istnieje_uzytkownik(text);

CREATE OR REPLACE FUNCTION public.istnieje_uzytkownik(
	we_login text)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	ilosc integer;
begin
	select count(*)
	from public.uzytkownik u
	where u.login=we_login
	into ilosc;
	
	if ilosc>0 then
		return true;
	else
		return false;
	end if;
	
end
$BODY$;

ALTER FUNCTION public.istnieje_uzytkownik(text)
    OWNER TO postgres;
