CREATE FUNCTION tomes_with_aspects()
RETURNS TABLE(id INT, name TEXT, tier INT, aspect aspects)
LANGUAGE sql 
AS $$
	SELECT tomes.id, tomes.name, tomes.tier, tome_aspects.aspect FROM tomes, tome_aspects WHERE tome_aspects.tome_id = tomes.id;
$$;

CREATE FUNCTION tomes_by_aspect(aspect_search aspects)
RETURNS TABLE(id INT, name TEXT, tier INT)
LANGUAGE sql 
AS $$
	SELECT tomes.id, tomes.name, tomes.tier FROM tomes, tome_aspects WHERE tome_aspects.tome_id = tomes.id AND tome_aspects.aspect = aspect_search;
$$;
