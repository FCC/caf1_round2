--mike byrne
--federal communications commission
--aug 21, 2013
--Connect America Fund 1 Round 2
--load table state
--table analysis.caf1_round2_state
drop table if exists analysis.caf1_round2_state;

--State,
CREATE TABLE analysis.caf1_round2_state
(
  state character varying(2),
  no_acs_locations integer,
  no_att_locations integer,
  no_centurylink_locations integer,
  no_fairpoint_locations integer,
  no_frontier_locations integer,
  no_hawaiian_locations integer,
  no_prtc_locations integer,
  no_windstream_locations integer,
  total_locations integer,
  total_dollar_support integer
)
WITH (
  OIDS=TRUE
);
ALTER TABLE analysis.caf1_round2_state OWNER TO postgres;

copy analysis.caf1_round2_state
  from '/Users/feomike/documents/analysis/2013/caf1_round2/caf1_round2_state.csv'
  csv header delimiter ',';
