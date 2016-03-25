defmodule ExTwilio.Mixfile do
  use Mix.Project

  def project do
    [app: :travis_plt_generator,
     version: "0.0.1",
     elixir: "~> 1.0",
     name: "Travis PLT Generator",
     source_url: "https://github.com/danielberkompas/ex_twilio",
     dialyzer: [
       plt_apps: application[:applications],
       plt_file: "plts/#{plt_filename}",
       flags: ["--no_native"]
     ],
     deps: deps]
  end

  def application do
    [ applications: [ :crypto, :gproc, :cowboy, :asn1, :public_key, :ssl, :exjsx, :signaturex, :httpoison, :watcher ]]
  end

  defp deps do
    [ {:dialyxir, "~> 0.3"},
      {:cowboy, "~> 1.0.0" },
      {:exjsx, "~> 3.0"},
      {:signaturex, "~> 1.0"},
      {:gproc, "~> 0.3.0"},
      {:meck, "~> 0.8.2", only: :test},
      {:pusher_client, github: "edgurgel/pusher_client", only: :test},
      {:pusher, "~> 0.1", only: :test},
      {:exrm, "~> 0.19.2", only: :prod},
      {:edip, "~> 0.4", only: :prod},
      {:inch_ex, "~> 0.5.1", only: :docs},
      {:httpoison, "~> 0.8"},
      {:ex2ms, "~> 1.4.0"},
      {:watcher, "~> 1.0.0"} ]
  end

  defp plt_filename do
    "elixir-#{System.version}-#{otp_release}.plt"
  end

  defp otp_release do
    case System.get_env("TRAVIS_OTP_RELEASE") do
      nil     -> :erlang.system_info(:otp_release)
      release -> release
    end
  end
end

