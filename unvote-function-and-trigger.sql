create function public.comment_unvote_function()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.comments set upvotes = upvotes - 1 where comment_id = old.comment_id;
  return old;
end;
$$;

create trigger comment_unvote_trigger
after delete on public.comment_upvotes
for each row execute function public.comment_unvote_function();