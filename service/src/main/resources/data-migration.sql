drop aggregate  date_level_achieved (point_increment int, dateAchieved timestamp without time zone, minPoints int, maxPoints int)
drop function date_level_achieved_final_func;
drop function date_level_achieved_func (agg_state custom_type1, point_increment int, dateAchieved timestamp without time zone, minPoints int, maxPoints int);
drop type custom_type1;


create type custom_type1 as (
    dateAchieved timestamp without time zone,
    points INT
);


create or replace function date_level_achieved_func(agg_state custom_type1, point_increment int, dateAchieved timestamp without time zone, minPoints int, maxPoints int, skillId varchar(255), userId varchar(255))
    returns custom_type1
    immutable
    language plpgsql
as $$
declare
    current_sum int;
    current_dateAchieved timestamp without time zone;
    retVal custom_type1;
begin
    if agg_state.points IS NULL then
        agg_state.points = 0;
    end if;
    current_sum := agg_state.points + point_increment;
    current_dateAchieved := agg_state.dateAchieved;

    raise notice '1 agg_state.dateAchieved [%], agg_state.points [%], point_increment [%], dateAchieved [%], skillId [%], userId [%] %', agg_state.dateAchieved, agg_state.points, point_increment, dateAchieved, skillId, userId, E'\n';

    if current_dateAchieved IS NULL AND current_sum >= minPoints then
        current_dateAchieved := dateAchieved;
--         raise notice 'current_dateAchieved is NULL: - current_sum % - dateAchieved % %', current_sum, dateAchieved, E'\n';
--     else
--         raise notice 'current_dateAchieved is NOT NULL: % - current_sum % - dateAchieved % %', current_dateAchieved, current_sum, dateAchieved, E'\n';
    end if;

--     select into retVal current_dateAchieved as dateAchieved, current_sum as points;
    retVal.dateAchieved := current_dateAchieved;
    retVal.points := current_sum;
    raise notice 'Returning date [%], points [%] %', retVal.dateAchieved, retVal.points, E'\n';
--    return custom_type1(current_date, current_sum);
    return retVal;
end;
$$;


create or replace function date_level_achieved_final_func(agg_state custom_type1)
    returns timestamp without time zone
    immutable
    language plpgsql
as $$
begin
    return agg_state.dateAchieved;
end;
$$;


create aggregate date_level_achieved (point_increment int, dateAchieved timestamp without time zone, minPoints int, maxPoints int, skillId varchar(255), userId varchar(255)) (
    sfunc = date_level_achieved_func,
    stype = custom_type1,
    finalfunc = date_level_achieved_final_func
);




select ups.user_id, date_level_achieved(sd2.point_increment, ups.performed_on, 15, 30)
from
    skill_definition sd2, skill_relationship_definition srd, user_performed_skill ups
where
        sd2.skill_id = ups.skill_id and
        sd2.id = srd.child_ref_id and
        srd.parent_ref_id = '101'
GROUP BY ups.user_id;