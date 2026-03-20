# 🌙 Eid Wishes Wall + Salami Collector

<div align="center">

![Eid Mubarak](https://img.shields.io/badge/Eid-Mubarak%20%F0%9F%8C%99-gold?style=for-the-badge&labelColor=0d0d30&color=f0c040)
![Status](https://img.shields.io/badge/Status-Live-brightgreen?style=for-the-badge&labelColor=0d0d30)
![Made in Bangladesh](https://img.shields.io/badge/Made%20in-Bangladesh%20%F0%9F%87%A7%F0%9F%87%A9-green?style=for-the-badge&labelColor=0d0d30)

**A real-time public Eid celebration platform — community wishes wall with a digital Salami leaderboard and bKash/Nagad deep-link payment flow.**

[🌐 Live Demo]() 

</div>

---

## ✨ Features

- 🌙 **Creator's Featured Message** — pinned personal Eid greeting from the site owner, always at the top
- 🏮 **Public Wishes Wall** — real-time lantern cards with 6 color themes, auto-updating without page refresh
- 💰 **Salami Collection** — bKash / Nagad deep-link buttons that open the payment app with amount pre-filled
- 🏆 **Live Leaderboard** — Gold / Silver / Bronze tier system, sorted by amount in real time
- ✨ **Visual Atmosphere** — animated starfield canvas, floating crescent moon, Eid particle effects
- 🕌 **Mosque Silhouette Footer** — custom SVG with twin minarets and central dome
- 📱 **Fully Responsive** — mobile-first design, optimized for the phones people actually use

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Frontend** | HTML5, CSS3, Vanilla JS | UI, animations, all business logic |
| **Database** | Supabase (PostgreSQL) | Data persistence + real-time subscriptions |
| **Security** | Supabase RLS + anon key | Public read/insert, no auth required |
| **Real-time** | Supabase WebSocket channels | Live wish and salami updates across all browsers |
| **Payments** | bKash / Nagad deep links | App-to-app handoff with pre-filled amount |
| **Fonts** | Google Fonts (Amiri, Tajawal) | Arabic + Latin + Bangla compatible |
| **Deployment** | Vercel | Zero-config static hosting, auto-deploy on push |

---

## 🗄️ Database Schema

```sql
CREATE TABLE public.wishes (
  id         UUID         DEFAULT gen_random_uuid() PRIMARY KEY,
  name       VARCHAR(50)  NOT NULL CHECK (char_length(trim(name)) >= 2),
  message    VARCHAR(280) NOT NULL CHECK (char_length(trim(message)) >= 5),
  theme      VARCHAR(20)  DEFAULT 'gold' NOT NULL,
  created_at TIMESTAMPTZ  DEFAULT now() NOT NULL
);

CREATE TABLE public.salamis (
  id         UUID         DEFAULT gen_random_uuid() PRIMARY KEY,
  name       VARCHAR(50)  NOT NULL CHECK (char_length(trim(name)) >= 2),
  amount     INTEGER      NOT NULL CHECK (amount >= 10 AND amount <= 50000),
  method     VARCHAR(20)  DEFAULT 'bKash' NOT NULL,
  created_at TIMESTAMPTZ  DEFAULT now() NOT NULL
);
```

Both tables have **Row Level Security (RLS)** enabled — public SELECT and INSERT only. UPDATE and DELETE are blocked at the database level.

---

## 🚀 Getting Started

### Prerequisites
- [Supabase](https://supabase.com) free account
- Any code editor (IntelliJ, VS Code, etc.)
- [Vercel](https://vercel.com) account for deployment

### Setup

**1. Clone the repository**
```bash
git clone 
```

**2. Set up Supabase**

Create a new project at [supabase.com](https://supabase.com), then run `supabase-schema.sql` in the SQL Editor. After that, enable real-time:

```sql
ALTER PUBLICATION supabase_realtime ADD TABLE public.wishes;
ALTER PUBLICATION supabase_realtime ADD TABLE public.salamis;
```

Go to **Project Settings → API** and copy your Project URL and anon/public key.

**3. Configure credentials**

Open `index.html` and update the four constants at the bottom of the file:

```javascript
const SUPABASE_URL  = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON = 'YOUR_ANON_KEY';
const BKASH_NUMBER  = 'YOUR_BKASH_NUMBER';
const NAGAD_NUMBER  = 'YOUR_NAGAD_NUMBER';
```

**4. Run locally**

Open `index.html` via your IDE's built-in server. In IntelliJ: right-click → **Open In → Browser**. The address bar must show `localhost:XXXX`, not `file://`.

---

## 📦 Deployment

```bash
git add .
git commit -m "🌙 Deploy Eid Wishes Wall"
git push origin main
```

Go to [vercel.com](https://vercel.com) → **New Project** → import your repo → **Deploy**. Live in 30 seconds.

---

## 📁 Project Structure

```
eid-wishes-wall/
│
├── index.html              ← Complete single-file app (HTML + all JS inline)
│   ├── Creator message     — Pinned featured greeting at the top
│   ├── Wish form + wall    — Submit, load, real-time card grid
│   ├── Salami section      — Amount picker, deep-link buttons, confirm form
│   └── Leaderboard         — Live ranked table with tier badges
│
├── style.css               ← All styles, animations, responsive rules
├── supabase-schema.sql     ← Run once in Supabase SQL Editor
├── .gitignore
└── README.md
```

---

## 💳 Payment Flow

```
User enters amount (or taps quick preset)
        ↓
Taps bKash or Nagad button
        ↓
Deep link opens payment app with number + amount pre-filled
        ↓
User completes payment in their app
        ↓
Returns to site, fills confirm form (name + amount + method)
        ↓
Entry appears on the leaderboard in real time
```

> Salami amounts are self-reported on an honor system. Money transfers happen directly between users via bKash/Nagad — the site tracks and displays them publicly.

---

## 🔄 How Real-time Works

```
User submits wish or salami
        ↓
Supabase INSERT → PostgreSQL
        ↓
PostgreSQL triggers replication event
        ↓
Supabase broadcasts via WebSocket channel
        ↓
All connected browsers receive the event instantly
        ↓
New card or leaderboard row appears — no page refresh needed
```

---

## 🎨 Wish Card Themes

| Theme | Accent | Icon |
|-------|--------|------|
| Gold | `#f0c040` | 🌙 |
| Emerald | `#2ecc71` | 🕌 |
| Purple | `#9b59b6` | ✨ |
| Crimson | `#e74c3c` | 🌸 |
| Teal | `#1abc9c` | ⭐ |
| Rose | `#e91e8c` | 🌺 |

---

## 🏆 Salami Tier System

| Tier | Minimum | Badge color |
|------|---------|-------------|
| 🥇 Gold | ৳ 500+ | Gold |
| 🥈 Silver | ৳ 200+ | Silver |
| 🥉 Bronze | ৳ 50+ | Bronze |

---

## 🔒 Security

- Row Level Security on all tables — no unauthorized writes from the browser
- Rate limiting via `localStorage` — 1 wish per 5 min, 1 salami confirmation per 10 min per browser
- Input validation enforced on both client and database level
- HTML escaping on all user-generated content — XSS protected
- Anon key only exposed — service role key never sent to the browser

---

## 🗺️ Roadmap

### V1 ✅
- [x] Creator featured message
- [x] Real-time wishes wall with 6 lantern themes
- [x] bKash / Nagad deep-link payment flow
- [x] Live leaderboard with Gold / Silver / Bronze tiers
- [x] Confetti on submission
- [x] Rate limiting

### V2 Planned
- [ ] Admin panel to remove spam
- [ ] Like / react on wish cards
- [ ] Share wish as downloadable image card
- [ ] bKash Merchant API for verified payment confirmation
- [ ] Bangla / Arabic / English language toggle
- [ ] Infinite scroll for large wish volumes

---

## 👨‍💻 Author

**Hazrat Ali**

🎓 { 🚁 Researcher | 💻 Programmer | 🚀 Entrepreneur | 🛸Businessman }

📧 rhslion34@gmail.com

🌐 [Portfolio]() · 
💼 [GitHub]()

---

— free to use, modify, and distribute.

---

<div align="center">

Made With ❤️ Hazrat Ali

**عيد مبارك · Eid Mubarak · ঈদ মোবারক 🌙**

</div>
