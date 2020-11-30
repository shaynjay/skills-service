/**
 * Copyright 2020 SkillTree
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

drop aggregate  date_level_achieved(point_increment int, date_achieved timestamp without time zone, minPointsRequired int);
drop function date_level_achieved_final_func;
drop function date_level_achieved_func (agg_state date_achieved_points, point_increment int, date_achieved timestamp without time zone, minPointsRequired int);
drop type date_achieved_points;


create type date_achieved_points as (
    date_achieved timestamp without time zone,
    points INT
);


create or replace function date_level_achieved_func(agg_state date_achieved_points, point_increment int, date_achieved timestamp without time zone, minPointsRequired int)
    returns date_achieved_points
    immutable
    language plpgsql
as $$
declare
    current_sum int;
    current_date_achieved timestamp without time zone;
    retVal date_achieved_points;
begin
    current_sum := agg_state.points + point_increment;
    current_date_achieved := agg_state.date_achieved;

    raise notice '1 agg_state.date_achieved [%], agg_state.points [%], point_increment [%], date_achieved [%] %', agg_state.date_achieved, agg_state.points, point_increment, date_achieved, E'\n';

    if current_date_achieved IS NULL AND current_sum >= minPointsRequired then
        current_date_achieved := date_achieved;
    end if;

    retVal.date_achieved := current_date_achieved;
    retVal.points := current_sum;
    raise notice 'Returning date [%], points [%] %', retVal.date_achieved, retVal.points, E'\n';
    return retVal;
end;
$$;


create or replace function date_level_achieved_final_func(agg_state date_achieved_points)
    returns timestamp without time zone
    immutable
    language plpgsql
as $$
begin
    return agg_state.date_achieved;
end;
$$;


create aggregate date_level_achieved (point_increment int, date_achieved timestamp without time zone, minPointsRequired int) (
    sfunc = date_level_achieved_func,
    stype = date_achieved_points,
    initcond = '(, 0)',
    finalfunc = date_level_achieved_final_func
);




UPDATE user_achievement ua SET achieved_on=innerData.dateAchieved
FROM (
         select ups.user_id, date_level_achieved(sd2.point_increment, ups.performed_on, 40 order by ups.performed_on asc) dateAchieved
         from
             skill_definition sd2, skill_relationship_definition srd, user_performed_skill ups
         where
                 sd2.skill_id = ups.skill_id and
                 sd2.id = srd.child_ref_id and
                 srd.parent_ref_id = '101'
         GROUP BY ups.user_id
     ) as innerData
WHERE  ua.user_id = innerData.user_id and ua.level = 4 and ua.skill_id = 'Subject Id';