# JRSH App

A timetable, library & profile app for students and tutors.

## ⚡ Quick Setup (5 steps)

### 1. Get your Supabase anon key
1. Go to [supabase.com](https://supabase.com) → your project
2. Click **Settings** (gear icon) → **API**
3. Copy the **anon / public** key (starts with `eyJ...`)

### 2. Run the database schema
1. In Supabase dashboard → **SQL Editor**
2. Paste and run the contents of `jrsh-schema.sql`

### 3. Set your environment variable
Edit `.env` and replace `PASTE_YOUR_ANON_KEY_HERE` with your anon key:
```
VITE_SUPABASE_URL=https://bodeplbamprefhdrckyp.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 4. Install & run
```bash
npm install
npm run dev
```
Open http://localhost:5173

### 5. Deploy to GitHub Pages / Vercel / Netlify
```bash
npm run build
# then push the dist/ folder or connect to Vercel
```

## Deploy to Vercel (easiest)
1. Push this repo to GitHub
2. Go to [vercel.com](https://vercel.com) → Import project
3. Add environment variables: `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`
4. Deploy — you get a live URL instantly

## Project Structure
```
jrsh/
├── index.html
├── package.json
├── vite.config.js
├── jrsh-schema.sql      ← Run this in Supabase SQL Editor
├── .env                 ← Add your anon key here
└── src/
    ├── main.jsx
    ├── supabase.js      ← Supabase client
    └── App.jsx          ← Full app (student + tutor UI)
```

## Features
- **Student**: Add lesson slots, request tutors, browse study materials
- **Tutor**: View booked sessions (from accepted requests), publish study materials
- **Shared**: Archive with likes/saves, dark mode, identity profiles
