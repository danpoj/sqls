create function public.after_auth_user_created_function()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.raw_app_meta_data is not null then
    if new.raw_app_meta_data ? 'provider' and new.raw_app_meta_data->>'provider' = 'email' then
      insert into public.profiles (profile_id, name, username)
      values (new.id, 'name', substr(md5(random()::text), 1, 8));

      -- Later, add a social login conditional.
    end if;
  end if;
  return new;
end;
$$;

create trigger after_auth_user_created_trigger
after insert on auth.users
for each row execute function public.after_auth_user_created_function();