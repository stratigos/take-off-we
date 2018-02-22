# Migrations - basically, its like Rails (see ch 15)
# Because history is cool: the directory structure begins with `priv` as the
#  term is defined in Erlang as a dir for *"...holding executables, other
#  programs, and various specific files needed for the application to work"*.
# That is to say, that "migrations arent really application code", so put em
#  in thie misc dir, along with JS and CSS assets and the like.
defmodule Physics.Repo.Migrations.AddSolarFlaresTable do
  use Ecto.Migration

  def change do
    create table(:solar_flares) do
      add :classification, :string, size: 1
      add :scale, :float
      add :stations, :integer
      timestamps() # Dont go typing any Ruby now...
    end
  end
end
