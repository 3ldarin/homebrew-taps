class Foundry < Formula
  # desc "Foundry is a smart contract development toolchain. Foundry manages your
  # dependencies, compiles your project, runs tests, deploys, and lets you
  # interact with the chain from the command-line and via Solidity scripts."
  desc "Smart contract development toolchain"
  homepage "https://book.getfoundry.sh"
  url "https://github.com/foundry-rs/foundry.git",
      revision: "ae89c92ee32b38d525429fe9c216a0919bc7bed1"
  version "0.2.0"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/foundry-rs/foundry.git", branch: "master"

  depends_on "rust" => :build
  depends_on "libusb"

  def foundry_cargo_call(path)
    ["cargo", "install", "--locked", "--profile=release", "--root=#{prefix}", "--path=#{path[:path]}"]
  end

  def install
    system(*foundry_cargo_call(path: "./crates/forge"))
    system(*foundry_cargo_call(path: "./crates/cast"))
    system(*foundry_cargo_call(path: "./crates/chisel"))
    system(*foundry_cargo_call(path: "./crates/anvil"))
  end

  test do
    assert_match(/forge 0.2.0 .*/, shell_output("#{bin}/forge --version"))
    assert_match(/cast 0.2.0 .*/, shell_output("#{bin}/cast --version"))
    assert_match(/chisel 0.2.0 .*/, shell_output("#{bin}/chisel --version"))
    assert_match(/anvil 0.2.0 .*/, shell_output("#{bin}/anvil --version"))
  end
end
