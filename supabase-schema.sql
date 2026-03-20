CREATE TABLE public.wishes (
                               id         UUID         DEFAULT gen_random_uuid() PRIMARY KEY,
                               name       VARCHAR(50)  NOT NULL CHECK (char_length(trim(name)) >= 2),
                               message    VARCHAR(280) NOT NULL CHECK (char_length(trim(message)) >= 5),
                               theme      VARCHAR(20)  DEFAULT 'gold' NOT NULL,
                               created_at TIMESTAMPTZ  DEFAULT now() NOT NULL
);

CREATE INDEX idx_wishes_time ON public.wishes(created_at DESC);

ALTER TABLE public.wishes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "wishes_public_read"
  ON public.wishes FOR SELECT
                                  USING (true);

CREATE POLICY "wishes_public_insert"
  ON public.wishes FOR INSERT
  WITH CHECK (
    char_length(trim(name))    BETWEEN 2 AND 50  AND
    char_length(trim(message)) BETWEEN 5 AND 280
  );

CREATE TABLE public.salamis (
                                id         UUID         DEFAULT gen_random_uuid() PRIMARY KEY,
                                name       VARCHAR(50)  NOT NULL CHECK (char_length(trim(name)) >= 2),
                                amount     INTEGER      NOT NULL CHECK (amount >= 10 AND amount <= 50000),
                                method     VARCHAR(20)  DEFAULT 'bKash' NOT NULL,
                                created_at TIMESTAMPTZ  DEFAULT now() NOT NULL
);

CREATE INDEX idx_salamis_amount ON public.salamis(amount DESC);

CREATE INDEX idx_salamis_time   ON public.salamis(created_at DESC);

ALTER TABLE public.salamis ENABLE ROW LEVEL SECURITY;

CREATE POLICY "salamis_public_read"
  ON public.salamis FOR SELECT
                                   USING (true);

CREATE POLICY "salamis_public_insert"
  ON public.salamis FOR INSERT
  WITH CHECK (
    amount >= 10 AND amount <= 50000 AND
    char_length(trim(name)) BETWEEN 2 AND 50
  );
