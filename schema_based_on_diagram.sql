CREATE TABLE "visits"(
    "animal_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL,
    "date_of_visit" DATE NOT NULL
);
CREATE TABLE "owners"(
    "id" BIGINT NOT NULL,
    "full_name" VARCHAR(50) NOT NULL,
    "age" INTEGER NOT NULL,
    "email" VARCHAR(120) NOT NULL
);
CREATE INDEX "owners_email_index" ON
    "owners"("email");
ALTER TABLE
    "owners" ADD PRIMARY KEY("id");
CREATE TABLE "animals"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "weight_kg" DECIMAL(8, 2) NOT NULL,
    "species_id" INTEGER NOT NULL,
    "owner_id" INTEGER NULL
);
ALTER TABLE
    "animals" ADD PRIMARY KEY("id");
CREATE TABLE "species"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "species" ADD PRIMARY KEY("id");
CREATE TABLE "specializations"(
    "vet_id" INTEGER NOT NULL,
    "species_id" INTEGER NOT NULL
);
CREATE INDEX "specializations_vet_id_species_id_index" ON
    "specializations"("vet_id", "species_id");
ALTER TABLE
    "specializations" ADD PRIMARY KEY("vet_id");
ALTER TABLE
    "specializations" ADD PRIMARY KEY("species_id");
CREATE TABLE "vets"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "date_of_graduation" DATE NOT NULL
);
ALTER TABLE
    "vets" ADD PRIMARY KEY("id");
ALTER TABLE
    "species" ADD CONSTRAINT "species_id_foreign" FOREIGN KEY("id") REFERENCES "specializations"("species_id");
ALTER TABLE
    "vets" ADD CONSTRAINT "vets_id_foreign" FOREIGN KEY("id") REFERENCES "specializations"("vet_id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animal_id_foreign" FOREIGN KEY("animal_id") REFERENCES "animals"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_owner_id_foreign" FOREIGN KEY("owner_id") REFERENCES "owners"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("id");