defmodule SpreedlyAirlinesElixir.FlightView do
  use SpreedlyAirlinesElixir.Web, :view

  def flights do 
    %{
      "1" => %{:number => "14980", :airline => "Spreedly Airlines", :from => "AMA", :to => "RDU", :price => 545.36},
      "2" => %{:number => "4151", :airline => "Spreedly Airlines", :from => "DFW", :to => "SFO", :price => 192.12},
      "3" => %{:number => "19068", :airline => "Spreedly Airlines", :from => "LAX", :to => "DXB", :price => 886.95},
      "4" => %{:number => "69900", :airline => "Spreedly Airlines", :from => "DFW", :to => "HKG", :price => 743.51},
      "5" => %{:number => "8756", :airline => "Spreedly Airlines", :from => "AMA", :to => "CDG", :price => 1472.34}
    }
  end
end
