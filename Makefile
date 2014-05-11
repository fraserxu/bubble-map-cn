build/gz_2010_us_050_00_20m.zip:
	mkdir -p $(dir $@)
	curl -o $@ http://www2.census.gov/geo/tiger/GENZ2010/$(notdir $@)

build/gz_2010_us_050_00_20m.shp: build/gz_2010_us_050_00_20m.zip
	unzip -od $(dir $@) $<
	touch $@

build/counties.json: raw/CHN_adm/CHN_adm1.shp
	node_modules/.bin/topojson \
		-o $@ \
		--projection='width=960,height=600,d3.geo.albers().center([135.00, 25.00]).rotate([0, 65, 30]).parallels([25, 47]).scale(1000).translate([width / 2, height / 2])' \
		--simplify=.5 \
		--filter=none \
		-- counties=$<