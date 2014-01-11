defmodule Repo.Migrations.CreateWeather do
  use Ecto.Migration

  def up do
    %s"CREATE TABLE IF NOT EXISTS weather (
      id serial primary key,
      city varchar(40),
      temp_lo integer,
      temp_hi integer,
      prcp float)
    "
  end

  def down do
    "DROP TABLE weather"
  end
end
