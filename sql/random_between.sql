create or replace function random_between (
	in lo integer,
	in hi integer
)
returns integer 
language plpgsql
volatile
strict
parallel safe
as $$
declare
begin
	if (lo > hi)
	then
		return floor(random() * (lo - hi + 1) + hi);
	else
		return floor(random() * (hi - lo + 1) + lo);
	end if;
end; $$;
