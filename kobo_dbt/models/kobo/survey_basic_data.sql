SELECT 	
	a.id::int,
	a.full_name::varchar(128),
	a.first_name::varchar(64),
	a.last_name::varchar(32),
	a.email::varchar(100),
	a.phone::varchar(14),
	a.created_date::date,
	a.data_origin::text,
	a.geolocation,
	a.latitude::text,
	a.longitude::text
FROM(
	SELECT
		"name" AS full_name,
		regexp_replace("name",'(.+)\s\S+$','\1') as first_name,
		regexp_replace("name",'.+[\s]','') as last_name,
		"_id" AS id,
		"email",
		CONCAT('+88', vcell) AS phone,
		"a1" AS created_date,
		"_status" AS data_origin,
		"_geolocation" AS geolocation,
	    _geolocation['0'] AS latitude,
	    _geolocation['1'] AS longitude
	FROM {{ source('public', 'kobo_form_stream') }}
) AS a

