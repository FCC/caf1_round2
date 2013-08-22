--mike byrne
--federal communications commission
--aug 21, 2013
--Connect America Fund 1 Round 2
--load table block

--table analysis.caf1_round2_block
drop table if exists analysis.caf1_round2_block;

CREATE TABLE analysis.caf1_round2_block
(
  block_fips character varying(15),
  state_fips character varying(2),
  state character varying(2),
  carrier character varying(200),
  no_high_cost_locations numeric,
  no_med_cost_locations numeric,
  challeng character varying(1)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE analysis.caf1_round2_block OWNER TO postgres;

CREATE INDEX analysis_caf1_round2_block_block_fips_btree
  ON analysis.caf1_round2_block
  USING btree
  (block_fips);

copy analysis.caf1_round2_block
  from '/Users/feomike/documents/analysis/2013/caf1_round2/caf1_round2_blocks.csv'
  csv header delimiter ',';
