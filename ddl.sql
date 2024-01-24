drop
    extension if exists pgcrypto;
CREATE
    EXTENSION pgcrypto;
drop
    extension if exists citext cascade;
CREATE
    EXTENSION citext;


drop table if exists Users cascade;
create table Users
(
    user_id   serial PRIMARY KEY not NULL,
    email     citext unique      not NULL,
    pass_hash varchar(64)        not NULL
);

drop table if exists Maps cascade;
create table Maps
(
    map_id          serial PRIMARY KEY                 not NULL,
    admin_id        integer references Users (user_id) not NULL,
    pass_hash       varchar(64),
    map_name        varchar(255)                       not NULL,
    map_description varchar(255),
    created_at      timestamp                          not null,
    is_removed      bool                               not NULL default false
);


drop table if exists Nodes cascade;
create table Nodes
(
    node_id        serial PRIMARY KEY               not NULL,
    map_id         integer references Maps (map_id) not NULL,
    label          varchar(255)                     not NULL,
    description    text,
    parent_node_id integer references Nodes (node_id),
    is_removed     bool                             not NULL default false
);

drop type if exists QuestionType cascade;
create type QuestionType as ENUM ('SINGLE_CHOICE', 'MULTIPLE_CHOICE');

drop table if exists Questions cascade;
create table Questions
(
    question_id   serial PRIMARY KEY                 not NULL,
    node_id       integer references Nodes (node_id) not NULL,
    question_text varchar(255)                       not NULL,
    type          QuestionType                       not NULL,
    is_removed    bool                               not NULL default false
);

drop table if exists Answers cascade;
create table Answers
(
    answer_id   serial PRIMARY KEY                         not NULL,
    question_id integer references Questions (question_id) not NULL,
    answer_text varchar(255)                               not NULL,
    is_correct  bool                                       not NULL,
    is_removed  bool                                       not NULL default false
);

drop table if exists NodeProgress cascade;
create table NodeProgress
(
    user_id   integer references Users (user_id) not NULL,
    node_id   integer references Nodes (node_id) not NULL,
    is_marked bool                               not null,
    constraint unique_marked_node unique (user_id, node_id)
);

drop table if exists AnswerProgress cascade;
create table AnswerProgress
(
    user_id            integer references Users (user_id)         not NULL,
    question_id        integer references Questions (question_id) not NULL,
    selected_answer_id integer references Answers (answer_id)     not NULL,
    is_removed         bool                                       not NULL default false,
    constraint unique_answer_complete unique (user_id, question_id)
);


drop table if exists SelectedMaps cascade;
create table SelectedMaps
(
    user_id    integer references Users (user_id) not NULL,
    map_id     integer references Maps (map_id)   not NULL,
    is_removed bool                               not NULL default false,
    constraint unique_maps_selecting unique (user_id, map_id)
);

drop table if exists UserSessions cascade;
create table UserSessions
(
    user_id    integer references Users (user_id) not NULL,
    device_id  varchar(255)                       not NULL,
    session_id varchar(255)                       not NULL,
    is_removed bool                               not NULL default false,
    created_at timestamp                          not NULL
);
drop
    extension if exists pgcrypto;
CREATE
    EXTENSION pgcrypto;
drop
    extension if exists citext cascade;
CREATE
    EXTENSION citext;


drop table if exists Users cascade;
create table Users
(
    user_id   serial PRIMARY KEY not NULL,
    email     citext unique      not NULL,
    pass_hash varchar(64)        not NULL
);

drop table if exists Maps cascade;
create table Maps
(
    map_id          serial PRIMARY KEY                 not NULL,
    admin_id        integer references Users (user_id) not NULL,
    pass_hash       varchar(64),
    map_name        varchar(255)                       not NULL,
    map_description varchar(255),
    is_removed      bool                               not NULL default false
);


drop table if exists Nodes cascade;
create table Nodes
(
    node_id        serial PRIMARY KEY               not NULL,
    map_id         integer references Maps (map_id) not NULL,
    label          varchar(255)                     not NULL,
    description    text,
    parent_node_id integer references Nodes (node_id),
    is_removed     bool                             not NULL default false
);

drop type if exists QuestionType cascade;
create type QuestionType as ENUM ('SINGLE_CHOICE', 'MULTIPLE_CHOICE');

drop table if exists Questions cascade;
create table Questions
(
    question_id   serial PRIMARY KEY                 not NULL,
    node_id       integer references Nodes (node_id) not NULL,
    question_text varchar(255)                       not NULL,
    type          QuestionType                       not NULL,
    is_removed    bool                               not NULL default false
);

drop table if exists Answers cascade;
create table Answers
(
    answer_id   serial PRIMARY KEY                         not NULL,
    question_id integer references Questions (question_id) not NULL,
    answer_text varchar(255)                               not NULL,
    is_correct  bool                                       not NULL,
    is_removed  bool                                       not NULL default false
);

drop table if exists NodeProgress cascade;
create table NodeProgress
(
    user_id   integer references Users (user_id) not NULL,
    node_id   integer references Nodes (node_id) not NULL,
    is_marked bool                               not null,
    constraint unique_marked_node unique (user_id, node_id)
);

drop table if exists AnswerProgress cascade;
create table AnswerProgress
(
    user_id            integer references Users (user_id)         not NULL,
    question_id        integer references Questions (question_id) not NULL,
    selected_answer_id integer references Answers (answer_id)     not NULL,
    is_removed         bool                                       not NULL default false,
    constraint unique_answer_complete unique (user_id, question_id)
);


drop table if exists SelectedMaps cascade;
create table SelectedMaps
(
    user_id    integer references Users (user_id) not NULL,
    map_id     integer references Maps (map_id)   not NULL,
    is_removed bool                               not NULL default false,
    constraint unique_maps_selecting unique (user_id, map_id)
);

drop table if exists UserSessions cascade;
create table UserSessions
(
    user_id    integer references Users (user_id) not NULL,
    device_id  varchar(255)                       not NULL,
    session_id varchar(255)                       not NULL,
    is_removed bool                               not NULL default false,
    created_at timestamp                          not NULL
);
