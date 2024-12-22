-- 基于用户id 找到用户角色id
SELECT role_id FROM tb_user_roles where user_id = 1;

-- 基于角色id 找到菜单id
select menu_id from tb_role_menus where role_id in (1);

-- 基于菜单id 找到权限标识
select permission from tb_menus where id in (1,2,3);


select permission from tb_menus where id in (select menu_id from tb_role_menus where role_id in (SELECT role_id FROM tb_user_roles where user_id = 1));


select distinct permission from 
tb_user_roles ur join tb_role_menus rm on ur.role_id = rm.role_id
join tb_menus m on rm.menu_id = m.id
where ur.user_id = 1;


select * from tb_roles inner join tb_role_menus;

