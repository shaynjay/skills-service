--
-- Copyright 2020 SkillTree
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

INSERT INTO public.user_attrs (id, user_id, first_name, last_name, dn, email, nickname, user_id_for_display, created, updated) VALUES (1, 'skills@skills.org', 'Skills', 'Test', null, 'skills@skills.org', 'Skills Test', 'skills@skills.org', '2020-12-04 16:14:59.405135', '2020-12-04 16:14:59.405135');
INSERT INTO public.user_attrs (id, user_id, first_name, last_name, dn, email, nickname, user_id_for_display, created, updated) VALUES (2, 'user0', null, null, null, null, '', 'user0', '2020-12-04 16:15:00.549236', '2020-12-04 16:15:00.549236');


INSERT INTO public.users (id, user_id, password, created, updated) VALUES (1, 'skills@skills.org', '$2a$10$BxMd3YpLN9LhJI2i2J1PPe7bVR7Z5xh6pjP/1EpeCtSlHO6tdpX2y', '2020-12-04 16:14:59.405135', '2020-12-04 16:14:59.405135');

INSERT INTO public.user_roles (id, user_ref_id, user_id, role_name, project_id, created, updated) VALUES (1, 1, 'skills@skills.org', 'ROLE_APP_USER', null, '2020-12-04 16:14:59.405135', '2020-12-04 16:14:59.405135');

INSERT INTO public.project_definition (id, project_id, name, client_secret, total_points, created, updated) VALUES (1, 'TestProject1', 'Test Project#1', 'mZI0mKemu41L4S1ug2GT85TIV5Plu499', 200, '2020-12-04 16:14:59.924715', '2020-12-04 16:14:59.924715');

INSERT INTO public.user_roles (id, user_ref_id, user_id, role_name, project_id, created, updated) VALUES (2, 1, 'skills@skills.org', 'ROLE_PROJECT_ADMIN', 'TestProject1', '2020-12-04 16:14:59.924715', '2020-12-04 16:14:59.924715');

INSERT INTO public.skill_definition (id, project_id, skill_id, proj_ref_id, name, point_increment, point_increment_interval, increment_interval_max_occurrences, total_points, description, help_url, display_order, type, custom_icon_ref_id, icon_class, start_date, end_date, version, created, updated, enabled) VALUES (2, 'TestProject1', 'skill1', null, 'Test Skill 1', 200, 480, 1, 200, '84020', '84021', 1, 'Skill', null, null, null, null, 0, '2020-12-04 16:15:00.351000', '2020-12-04 16:15:00.351000', null);
INSERT INTO public.skill_definition (id, project_id, skill_id, proj_ref_id, name, point_increment, point_increment_interval, increment_interval_max_occurrences, total_points, description, help_url, display_order, type, custom_icon_ref_id, icon_class, start_date, end_date, version, created, updated, enabled) VALUES (1, 'TestProject1', 'TestSubject1', 1, 'Test Subject #1', 0, 0, 0, 200, null, null, 0, 'Subject', null, 'fa fa-question-circle', null, null, 0, '2020-12-04 16:15:00.244000', '2020-12-04 16:15:00.408000', null);
-- INSERT INTO public.skill_definition (id, project_id, skill_id, proj_ref_id, name, point_increment, point_increment_interval, increment_interval_max_occurrences, total_points, description, help_url, display_order, type, custom_icon_ref_id, icon_class, start_date, end_date, version, created, updated, enabled) VALUES (3, 'TestProject1', 'badge1', 1, 'Test Badge 1', 0, 0, 0, 0, null, null, 0, 'Badge', null, 'fa fa-question-circle', null, null, 0, '2020-12-04 16:15:00.462000', '2020-12-04 16:15:00.462000', null);

INSERT INTO public.skill_relationship_definition (id, parent_ref_id, child_ref_id, type, created, updated) VALUES (1, 1, 2, 'RuleSetDefinition', '2020-12-04 16:15:00.376000', '2020-12-04 16:15:00.376000');
-- INSERT INTO public.skill_relationship_definition (id, parent_ref_id, child_ref_id, type, created, updated) VALUES (2, 3, 2, 'BadgeRequirement', '2020-12-04 16:15:00.497000', '2020-12-04 16:15:00.497000');

INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (1, 1, null, 1, 10, null, null, null, 'fas fa-user-ninja', 'White Belt', '2020-12-04 16:14:59.924715', '2020-12-04 16:14:59.924715');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (2, 1, null, 2, 25, null, null, null, 'fas fa-user-ninja', 'Blue Belt', '2020-12-04 16:14:59.924715', '2020-12-04 16:14:59.924715');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (3, 1, null, 3, 45, null, null, null, 'fas fa-user-ninja', 'Purple Belt', '2020-12-04 16:14:59.924715', '2020-12-04 16:14:59.924715');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (4, 1, null, 4, 67, null, null, null, 'fas fa-user-ninja', 'Brown Belt', '2020-12-04 16:14:59.924715', '2020-12-04 16:14:59.924715');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (5, 1, null, 5, 92, null, null, null, 'fas fa-user-ninja', 'Black Belt', '2020-12-04 16:14:59.924715', '2020-12-04 16:14:59.924715');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (6, null, 1, 1, 10, null, null, null, 'fas fa-user-ninja', 'White Belt', '2020-12-04 16:15:00.160407', '2020-12-04 16:15:00.160407');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (7, null, 1, 2, 25, null, null, null, 'fas fa-user-ninja', 'Blue Belt', '2020-12-04 16:15:00.160407', '2020-12-04 16:15:00.160407');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (8, null, 1, 3, 45, null, null, null, 'fas fa-user-ninja', 'Purple Belt', '2020-12-04 16:15:00.160407', '2020-12-04 16:15:00.160407');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (9, null, 1, 4, 67, null, null, null, 'fas fa-user-ninja', 'Brown Belt', '2020-12-04 16:15:00.160407', '2020-12-04 16:15:00.160407');
INSERT INTO public.level_definition (id, project_ref_id, skill_ref_id, level, percent, points_from, points_to, custom_icon_ref_id, icon_class, logical_name, created, updated) VALUES (10, null, 1, 5, 92, null, null, null, 'fas fa-user-ninja', 'Black Belt', '2020-12-04 16:15:00.160407', '2020-12-04 16:15:00.160407');

INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (1, 'user0', 'TestProject1', 'TestSubject1', 1, 1, 200, '2020-12-04 16:15:00.805000', '2020-12-04 16:15:00.805000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (2, 'user0', 'TestProject1', 'TestSubject1', 1, 2, 200, '2020-12-04 16:15:00.811000', '2020-12-04 16:15:00.811000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (3, 'user0', 'TestProject1', 'TestSubject1', 1, 3, 200, '2020-12-04 16:15:00.813000', '2020-12-04 16:15:00.813000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (4, 'user0', 'TestProject1', 'TestSubject1', 1, 4, 200, '2020-12-04 16:15:00.814000', '2020-12-04 16:15:00.814000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (5, 'user0', 'TestProject1', 'TestSubject1', 1, 5, 200, '2020-12-04 16:15:00.816000', '2020-12-04 16:15:00.816000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (6, 'user0', 'TestProject1', null, null, 1, 200, '2020-12-04 16:15:00.821000', '2020-12-04 16:15:00.821000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (7, 'user0', 'TestProject1', null, null, 2, 200, '2020-12-04 16:15:00.825000', '2020-12-04 16:15:00.825000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (8, 'user0', 'TestProject1', null, null, 3, 200, '2020-12-04 16:15:00.827000', '2020-12-04 16:15:00.827000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (9, 'user0', 'TestProject1', null, null, 4, 200, '2020-12-04 16:15:00.829000', '2020-12-04 16:15:00.829000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (10, 'user0', 'TestProject1', null, null, 5, 200, '2020-12-04 16:15:00.831000', '2020-12-04 16:15:00.831000', null);
INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (11, 'user0', 'TestProject1', 'skill1', 2, null, 200, '2020-12-04 16:15:00.835000', '2020-12-04 16:15:00.835000', null);
-- INSERT INTO public.user_achievement (id, user_id, project_id, skill_id, skill_ref_id, level, points_when_achieved, created, updated, notified) VALUES (12, 'user0', 'TestProject1', 'badge1', 3, null, 0, '2020-12-04 16:15:00.854000', '2020-12-04 16:15:00.854000', null);


INSERT INTO public.user_performed_skill (id, user_id, skill_ref_id, skill_id, project_id, performed_on, created, updated) VALUES (1, 'user0', 2, 'skill1', 'TestProject1', '2019-10-05 16:15:00.509000', '2020-12-04 16:15:00.668000', '2020-12-04 16:15:00.668000');