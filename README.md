I love ogr2ogr! This specific project required only the following line to load the fields I wanted into my table:

`$ ogr2ogr -f PostgreSQL "PG: dbname=whereami_co_development host=localhost port=5432" "COMaP_v9_public.gdb" -select "name, owner, manager, mgmt_code, mgmt_description, public_access" -nln "properties" -overwrite`


Colorado land ownership data courtesy COMaP v9 public: 
Lavender, A.E., M.M. Fink, S.E. Linn, D.M. Theobald. 2011. Colorado Ownership, Management, and Protection v9 Database. Colorado Natural Heritage Program and Geospatial Centroid, Colorado State University, Fort Collins, CO. (30 September). www.nrel.colostate.edu/projects/comap
Online Links:
www.nrel.colostate.edu/projects/comap
