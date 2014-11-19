CREATE DATABASE entrepot;
\c entrepot
CREATE EXTENSION postgis;
SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE "communes" (gid serial,
"id_geofla" numeric(10,0),
"code_comm" varchar(3),
"insee_com" varchar(5),
"nom_comm" varchar(50),
"statut" varchar(20),
"x_chf_lieu" int4,
"y_chf_lieu" int4,
"x_centroid" int4,
"y_centroid" int4,
"z_moyen" int2,
"superficie" numeric(10,0),
"population" float8,
"code_cant" varchar(2),
"code_arr" varchar(1),
"code_dept" varchar(2),
"nom_dept" varchar(30),
"code_reg" varchar(2),
"nom_region" varchar(30));
ALTER TABLE "communes" ADD PRIMARY KEY (gid);
SELECT AddGeometryColumn('','communes','geom','0','MULTIPOLYGON',2);
INSERT INTO "communes" ("id_geofla","code_comm","insee_com","nom_comm","statut","x_chf_lieu","y_chf_lieu","x_centroid","y_centroid","z_moyen","superficie","population","code_cant","code_arr","code_dept","nom_dept","code_reg","nom_region",geom) VALUES ('319','102','16102','COGNAC','Sous-préfecture','4409','65161','4405','65162','22','1491','18.6','97','2','16','CHARENTE','54','POITOU-CHARENTES','0106000000010000000103000000010000000D0000000000000020D71A41000000C02BD9584100000000B0C41A4100000040CED95841000000002CB41A4100000040EAD95841000000001CBA1A41000000C076DA584100000000CCD41A4100000000C5DC584100000000A8D21A41000000001CDD5841000000006CE01A4100000080C2DD58410000000028F81A41000000C0B1DD58410000000098FB1A410000000064DD584100000000240C1B41000000C0ACDB58410000000098001B410000008079DA584100000000DCE91A410000008010DA58410000000020D71A41000000C02BD95841');
CREATE INDEX "communes_geom_gist" ON "communes" USING GIST ("geom");
COMMIT;
