create function public.comment_upvote_function()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.comments set upvotes = upvotes + 1 where comment_id = new.comment_id;
  return new;
end;
$$;

create trigger upvote_trigger
after insert on public.comment_upvotes
for each row execute function public.comment_upvote_function();