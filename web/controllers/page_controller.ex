defmodule SpreedlyAirlinesElixir.PageController do
  use SpreedlyAirlinesElixir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  # Move to own controller?
  def transactions(conn, _params) do
    flights = [
      %{:number => "14980", :airline => "Spreedly Airlines", :from => "AMA", :to => "RDU", :price => 545.36},
      %{:number => "4151", :airline => "Spreedly Airlines", :from => "DFW", :to => "SFO", :price => 192.12},
      %{:number => "19068", :airline => "Spreedly Airlines", :from => "LAX", :to => "DXB", :price => 886.95},
      %{:number => "69900", :airline => "Spreedly Airlines", :from => "DFW", :to => "HKG", :price => 743.51},
      %{:number => "8756", :airline => "Spreedly Airlines", :from => "AMA", :to => "CDG", :price => 1472.34}
    ]
    conn
    |> assign(:flights, flights)
    |> render("transactions.html")
  end

  def flights(conn, _params) do
    flights = [
      %{:number => "14980", :airline => "Spreedly Airlines", :from => "AMA", :to => "RDU", :price => 545.36},
      %{:number => "4151", :airline => "Spreedly Airlines", :from => "DFW", :to => "SFO", :price => 192.12},
      %{:number => "19068", :airline => "Spreedly Airlines", :from => "LAX", :to => "DXB", :price => 886.95},
      %{:number => "69900", :airline => "Spreedly Airlines", :from => "DFW", :to => "HKG", :price => 743.51},
      %{:number => "8756", :airline => "Spreedly Airlines", :from => "AMA", :to => "CDG", :price => 1472.34}
    ]
    conn
    |> assign(:flights, flights)
    |> render("flights.html")
  end
end
