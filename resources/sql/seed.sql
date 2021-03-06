--TODO introduce the database transaction from a9
--TODO fix uninvited_comment trigger

--Tables
DROP TABLE IF EXISTS answers CASCADE;
DROP TABLE IF EXISTS answer_user CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS event_path CASCADE;
DROP TABLE IF EXISTS event_user CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS paths CASCADE;
DROP TABLE IF EXISTS polls CASCADE;
DROP TABLE IF EXISTS reports CASCADE;
DROP TABLE IF EXISTS users CASCADE;

DROP FUNCTION IF EXISTS uninvited_comment();
DROP TRIGGER IF EXISTS  uninvited_comment ON comments;
DROP FUNCTION IF EXISTS warning_ban();
DROP TRIGGER IF EXISTS  warning_ban ON users;
DROP FUNCTION IF EXISTS event_in_past();
DROP TRIGGER IF EXISTS  event_in_past ON events;

CREATE TABLE events (
	id SERIAL NOT NULL,
	description text,
	title text NOT NULL,
	event_start timestamp with time zone,
	event_end timestamp with time zone CHECK (event_start < event_end),
	event_visibility text NOT NULL,
	CONSTRAINT event_visibility CHECK ((event_visibility = ANY (ARRAY['Public'::text, 'Private'::text]))),
	event_type text NOT NULL,
	CONSTRAINT event_type  CHECK ((event_type = ANY (ARRAY['Trip'::text, 'Party'::text, 'Sport'::text, 'Education'::text, 'Culture'::text, 'Birthday'::text]))),
	gps text,
	is_deleted boolean NOT NULL
);

CREATE TABLE users (
	id SERIAL NOT NULL,
  email text NOT NULL,
  name text NOT NULL,
	birthdate date,
	nr_warnings integer,
	password text,
	profile_picture_path text,
	is_banned boolean,
	is_admin boolean,
	remember_token text,
	confirmation_code text
);

CREATE TABLE event_user (
	id_event integer NOT NULL,
  id_user integer NOT NULL,
	event_user_state text NOT NULL,
	CONSTRAINT event_user_state CHECK ((event_user_state = ANY (ARRAY['Deciding'::text,'Going'::text, 'Ignoring'::text, 'Owner'::text]))),
	is_invited boolean
);

CREATE TABLE comments (
	id SERIAL NOT NULL,
	id_event integer NOT NULL,
	id_user integer NOT NULL,
	comment_content text NOT NULL,
	replyto integer NOT NULL,
	"date" timestamp with time zone DEFAULT now()
);

CREATE TABLE polls (
	id SERIAL NOT NULL,
	id_event integer NOT NULL,
	id_user integer NOT NULL,
	description text,
	question text NOT NULL
);

CREATE TABLE answers (
	id SERIAL NOT NULL,
	id_poll integer NOT NULL,
	answer text NOT NULL
);

CREATE TABLE answer_user (
	id_answer integer NOT NULL,
	id_user integer NOT NULL
);

CREATE TABLE paths(
	id SERIAL NOT NULL,
	path_value text NOT NULL,
	multimedia_type text NOT NULL
	CONSTRAINT multimedia_type CHECK ((multimedia_type = ANY (ARRAY['Picture'::text, 'Video'::text])))
);

CREATE TABLE event_path(
	id_path integer NOT NULL,
	id_event integer NOT NULL
);

CREATE TABLE reports(
	id SERIAL NOT NULL,
	id_user integer NOT NULL,
	description text
);

-- Primary Keys and Uniques
ALTER TABLE ONLY events
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);

ALTER TABLE ONLY users
    ADD CONSTRAINT user_email_key UNIQUE (email);

ALTER TABLE ONLY users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);

ALTER TABLE ONLY event_user
    ADD CONSTRAINT event_user_pkey PRIMARY KEY (id_event,id_user);

ALTER TABLE ONLY comments
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);

ALTER TABLE ONLY polls
    ADD CONSTRAINT poll_pkey PRIMARY KEY (id);

ALTER TABLE ONLY answers
    ADD CONSTRAINT answer_pkey PRIMARY KEY (id);

ALTER TABLE ONLY answer_user
    ADD CONSTRAINT answer_user_pkey PRIMARY KEY (id_answer,id_user);

ALTER TABLE ONLY paths
    ADD CONSTRAINT path_pkey PRIMARY KEY (id);

ALTER TABLE ONLY event_path
    ADD CONSTRAINT event_path_pkey PRIMARY KEY (id_path);

ALTER TABLE ONLY reports
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);

-- Foreign Keys
ALTER TABLE ONLY event_user
  ADD CONSTRAINT event_user_id_event_fkey FOREIGN KEY (id_event) REFERENCES events(id) ON UPDATE CASCADE;

ALTER TABLE ONLY event_user
  ADD CONSTRAINT event_user_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE;

ALTER TABLE ONLY comments
	ADD CONSTRAINT comment_id_event_fkey FOREIGN KEY (id_event) REFERENCES events(id) ON UPDATE CASCADE;

ALTER TABLE ONLY comments
	ADD CONSTRAINT comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE;

ALTER TABLE ONLY polls
	ADD CONSTRAINT poll_id_event_fkey FOREIGN KEY (id_event) REFERENCES events(id) ON UPDATE CASCADE;

ALTER TABLE ONLY polls
	ADD CONSTRAINT poll_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE;

ALTER TABLE ONLY answers
	ADD CONSTRAINT answer_id_poll_fkey FOREIGN KEY (id_poll) REFERENCES polls(id) ON UPDATE CASCADE;

ALTER TABLE ONLY answer_user
	ADD CONSTRAINT answer_user_id_answer_fkey FOREIGN KEY (id_answer) REFERENCES answers(id) ON UPDATE CASCADE;

ALTER TABLE ONLY answer_user
	ADD CONSTRAINT answer_user_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE;

ALTER TABLE ONLY event_path
	ADD CONSTRAINT event_path_id_event_fkey FOREIGN KEY (id_event) REFERENCES events(id) ON UPDATE CASCADE;

ALTER TABLE ONLY event_path
	ADD CONSTRAINT event_path_id_path_fkey FOREIGN KEY (id_path) REFERENCES paths(id) ON UPDATE CASCADE;

ALTER TABLE ONLY reports
	ADD CONSTRAINT report_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE;

INSERT INTO events (id,description,title,event_start,event_end,event_visibility,event_type,gps,is_deleted)
VALUES (100,'One of the best student parties in summer, hope to see you there.','Student party','2018-05-30 22:00:00','2018-05-31 04:00:00','Private','Party','Espinho','false');
INSERT INTO events (id,description,title,event_start,event_end,event_visibility,event_type,gps,is_deleted)
VALUES (200,'Trip to the oceanside of Aveiro with hiking walk, dont miss this, it will be amazing!','Hiking trip','2018-07-15 12:00:00','2018-07-16 18:00:00','Public','Trip','Aveiro','false');
INSERT INTO events (id,description,title,event_start,event_end,event_visibility,event_type,gps,is_deleted)
VALUES (300,'The best salsa lesson you can attend. If you are new in dancing, dont worry, we will teach you everything!','Salsa lesson','2018-06-10 15:00:00','2018-06-11 17:00:00','Public','Culture','Lisbon','false');
INSERT INTO events (id,description,title,event_start,event_end,event_visibility,event_type,gps,is_deleted)
VALUES (400,'This workshop is for all FEUP students who are interested in programming.','VueJs workshop','2018-06-7 13:00:00','2018-06-8 15:00:00','Private','Education','FEUP','false');

INSERT INTO users (id,email,name,birthdate,nr_warnings,password,profile_picture_path,is_banned,is_admin)
VALUES (100,'admin@gmail.com','Admin IaAmIn','Dec 24, 1949',0,'$2y$10$jH6QTJC9ar8Epv3.96X3oOz.gCtoKjqTvDoNQqaVU4mqKSElopzVu',null,'false','true');

INSERT INTO users (id,email,name,birthdate,nr_warnings,password,profile_picture_path,is_banned,is_admin)
VALUES (101,'john@gmail.com','John','Dec 2, 1988',0,'$2y$10$mYlI7.VuA3sJ1UklCTO16uceHdaFTfjMUXygg5gAY/wnIZy7a.E02',null,'false','false');
INSERT INTO users (id,email,name,birthdate,nr_warnings,password,profile_picture_path,is_banned,is_admin)
VALUES (102,'maria@gmail.com','Maria','Oct 25, 1998',0,'$2y$10$QzScrM0AT7tpwR/2T2uR7.ibA7BvUPRu4a5cdwWuxkuDFYP/.LNeO',null,'false','false');
INSERT INTO users (id,email,name,birthdate,nr_warnings,password,profile_picture_path,is_banned,is_admin)
VALUES (103,'ariana@gmail.com','Ariana','Feb 14, 1995',0,'$2y$10$c0LRPSGZp8r7yFYsb.pGx.9SR2.LoDrNfAnRFLx3b2U4tEcpim5kq',null,'false','false');

INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (100,102,'Owner');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (200,102,'Going');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (300,102,'Deciding');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (200,100,'Owner');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (300,101,'Owner');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (300,103,'Deciding');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (400,103,'Owner');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (400,101,'Ignoring');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (300,100,'Deciding');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (100,101,'Ignoring');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (200,103,'Deciding');
INSERT INTO "event_user" (id_event,id_user,event_user_state)
VALUES (100,103,'Going');

INSERT INTO comments (id,id_event,id_user,comment_content,replyto,date)
VALUES (100,100,103,'See you there guys!',0,'2018-05-28 06:11:36');
INSERT INTO comments (id,id_event,id_user,comment_content,replyto,date)
VALUES (200,100,101,'See you Ariana!',100,'2018-05-28 17:19:36');
INSERT INTO comments (id,id_event,id_user,comment_content,replyto,date)
VALUES (300,200,102,'Do we need to some special clothes to this hiking?',0,'2018-05-27 10:25:38');
INSERT INTO comments (id,id_event,id_user,comment_content,replyto,date)
VALUES (400,200,100,'You just need some comfortable shoes and thats it!',300,'2018-05-27 10:36:36');
INSERT INTO comments (id,id_event,id_user,comment_content,replyto,date)
VALUES (500,300,103,'Is it problem when I am beginner in dancing? I dont feel very self-confident.',0,'2018-05-28 12:25:38');

INSERT INTO reports (id,id_user,description)
VALUES (100,103,'This user posted rude comments for my event');
INSERT INTO reports (id,id_user,description)
VALUES (200,102,'This user spammed my event with unpleasant comments');

--Triggers
	-- CREATE FUNCTION uninvited_comment() RETURNS TRIGGER AS
	-- $BODY$
	-- BEGIN
	--   IF EXISTS (SELECT * FROM event_user
	-- 		INNER JOIN events on events.id = event_user.id_event
	-- 		WHERE events.event_visibility = 'Private'
	-- 		 	AND (event_user.event_user_state != 'Going' OR event_user.event_user_state != 'Deciding' OR event_user.event_user_state != 'Owner')
	-- 			AND NEW.id_event = events.id AND NEW.id_user = event_user.id_user) THEN
	--     RAISE EXCEPTION 'An uninvited user cannot comment on a private event.';
	--   END IF;
	--   RETURN NEW;
	-- END
	-- $BODY$
	-- LANGUAGE plpgsql;
	--
	-- CREATE TRIGGER uninvited_comment
	--   BEFORE INSERT OR UPDATE ON comments
	--   FOR EACH ROW
	--     EXECUTE PROCEDURE uninvited_comment();

	CREATE FUNCTION warning_ban() RETURNS TRIGGER AS
	$BODY$
	BEGIN
	  IF EXISTS (SELECT * FROM users
			WHERE users.nr_warnings = 3
				AND users.is_banned = false) THEN
	    RAISE EXCEPTION 'A user with 3 warnings must be banned.';
	  END IF;
	  RETURN NEW;
	END
	$BODY$
	LANGUAGE plpgsql;

	CREATE TRIGGER warning_ban
	  BEFORE UPDATE ON users
	  FOR EACH ROW
	    EXECUTE PROCEDURE warning_ban();

	CREATE FUNCTION event_in_past() RETURNS TRIGGER AS
	$BODY$
	BEGIN
	  IF (NEW.event_start < NOW()::timestamp )THEN
	    RAISE EXCEPTION 'An events must not have a start date in the past';
	  END IF;
	  RETURN NEW;
	END
	$BODY$
	LANGUAGE plpgsql;

	CREATE TRIGGER event_in_past
	  BEFORE INSERT OR UPDATE ON events
		FOR EACH ROW
	  	EXECUTE PROCEDURE event_in_past();
