-- ══════════════════════════════════════════════════════
-- JRSH App — Supabase Schema
-- Run this entire file in your Supabase SQL Editor
-- ══════════════════════════════════════════════════════

-- 1. PROFILES (both students and tutors)
create table if not exists profiles (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz default now(),
  name        text not null,
  age         int,
  gender      text,
  location    text,
  role        text not null check (role in ('student','tutor')),
  -- student only
  grade       text,
  -- tutor only
  curriculum_level text,
  hourly_rate int,
  pfp_url     text
);

-- 2. LESSONS (student-created timetable slots)
create table if not exists lessons (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz default now(),
  student_id  uuid references profiles(id) on delete cascade,
  subject     text not null,
  day         text not null,
  from_hour   int not null,
  to_hour     int not null,
  description text,
  online      boolean default false
);

-- 3. TUTOR_REQUESTS (student requests a tutor for a lesson)
create table if not exists tutor_requests (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz default now(),
  lesson_id   uuid references lessons(id) on delete cascade,
  student_id  uuid references profiles(id) on delete cascade,
  tutor_id    uuid references profiles(id) on delete cascade,
  status      text default 'pending' check (status in ('pending','accepted','declined','cancelled')),
  -- denormalised for easy display on tutor side
  subject     text,
  day         text,
  from_hour   int,
  to_hour     int,
  online      boolean,
  description text,
  student_name text
);

-- 4. NOTES (tutor-published study materials)
create table if not exists notes (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz default now(),
  tutor_id    uuid references profiles(id) on delete cascade,
  tutor_name  text,
  title       text not null,
  subject     text not null,
  pdf_url     text,
  cover_url   text,
  cover_color text default '#c8e6c9',
  rating      numeric(3,1) default 0
);

-- 5. NOTE_INTERACTIONS (per-user likes & saves)
create table if not exists note_interactions (
  id          uuid primary key default gen_random_uuid(),
  note_id     uuid references notes(id) on delete cascade,
  user_id     uuid references profiles(id) on delete cascade,
  liked       boolean default false,
  saved       boolean default false,
  unique(note_id, user_id)
);

-- ── Row Level Security (open for now — tighten with auth later) ──
alter table profiles          enable row level security;
alter table lessons           enable row level security;
alter table tutor_requests    enable row level security;
alter table notes             enable row level security;
alter table note_interactions enable row level security;

create policy "public read profiles"          on profiles          for select using (true);
create policy "public insert profiles"        on profiles          for insert with check (true);
create policy "public update profiles"        on profiles          for update using (true);

create policy "public read lessons"           on lessons           for select using (true);
create policy "public insert lessons"         on lessons           for insert with check (true);
create policy "public update lessons"         on lessons           for update using (true);
create policy "public delete lessons"         on lessons           for delete using (true);

create policy "public read requests"          on tutor_requests    for select using (true);
create policy "public insert requests"        on tutor_requests    for insert with check (true);
create policy "public update requests"        on tutor_requests    for update using (true);

create policy "public read notes"             on notes             for select using (true);
create policy "public insert notes"           on notes             for insert with check (true);
create policy "public update notes"           on notes             for update using (true);
create policy "public delete notes"           on notes             for delete using (true);

create policy "public read interactions"      on note_interactions for select using (true);
create policy "public insert interactions"    on note_interactions for insert with check (true);
create policy "public update interactions"    on note_interactions for update using (true);
