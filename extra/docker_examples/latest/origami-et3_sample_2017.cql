CREATE KEYSPACE et3_sample_2017 WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};
CREATE TABLE et3_sample_2017.metrology (
    subclass text,
    source text,
    day int,
    label text,
    time int,
    host text,
    stamp int,
    value text,
    PRIMARY KEY ((subclass, source, day), label, time, host, stamp));

INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pa', 677, 'et3-ops-1', 138793740, '{"link":"::::Qc::","value":10}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pb', 677, 'et3-ops-1', 138794100, '{"link":"::::Qc::","value":11}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pc', 677, 'et3-ops-1', 138797700, '{"link":"::::Qc::","value":12}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qa', 677, 'et3-ops-1', 138793740, '{"link":"::::Qc::","value":10}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qb', 677, 'et3-ops-1', 138794100, '{"link":"::::Qc::","value":11}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qc', 677, 'et3-ops-1', 138797700, '{"link":"::::Qc::","value":12}');

INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pa', 677, 'et3-ops-2', 138790740, '{"link":"::::Qc::","value":7}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pb', 677, 'et3-ops-2', 138791100, '{"link":"::::Qc::","value":8}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pc', 677, 'et3-ops-2', 138794700, '{"link":"::::Qc::","value":9}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qa', 677, 'et3-ops-2', 138790740, '{"link":"::::Qc::","value":7}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qb', 677, 'et3-ops-2', 138791100, '{"link":"::::Qc::","value":8}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qc', 677, 'et3-ops-2', 138794700, '{"link":"::::Qc::","value":9}');

INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pa', 677, 'et3-ops-3', 138690740, '{"link":"::::Qc::","value":12}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pb', 677, 'et3-ops-3', 138691100, '{"link":"::::Qc::","value":13}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Pc', 677, 'et3-ops-3', 138694700, '{"link":"::::Qc::","value":14}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qa', 677, 'et3-ops-3', 138690740, '{"link":"::::Qc::","value":12}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qb', 677, 'et3-ops-3', 138691100, '{"link":"::::Qc::","value":13}');
INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qc', 677, 'et3-ops-3', 138694700, '{"link":"::::Qc::","value":14}');

INSERT INTO et3_sample_2017.metrology (subclass, source, day, label, time, host, stamp, value) VALUES ('data', 'oa38', 20, 'Qc', 677, 'et3-ops-3', 1491229542, '{"link":"::::Qc::","value":100}');
