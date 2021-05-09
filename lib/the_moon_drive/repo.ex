defmodule TheMoonDrive.Repo do
  use Ecto.Repo,
    otp_app: :the_moon_drive,
    adapter: Ecto.Adapters.Postgres
end
