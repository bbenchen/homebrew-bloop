class Bloop < Formula
  desc "Installs the Bloop CLI for Bloop, a build server to compile, test and run Scala fast"
  homepage "https://github.com/scalacenter/bloop"
  version "1.4.7"
  url "https://github.com/scalacenter/bloop/releases/download/v1.4.7/bloop-coursier.json"
  sha256 "bfa16f607bdd86cae306c74a5127b4eb531e7be973954c9372fc255e54263833"
  bottle :unneeded

  depends_on "bash-completion"
  depends_on "coursier/formulas/coursier"
  depends_on "openjdk"

  resource "bash_completions" do
    url "https://github.com/scalacenter/bloop/releases/download/v1.4.7/bash-completions"
    sha256 "da6b7ecd4109bd0ff98b1c452d9dd9d26eee0d28ff604f6c83fb8d3236a6bdd1"
  end

  resource "zsh_completions" do
    url "https://github.com/scalacenter/bloop/releases/download/v1.4.7/zsh-completions"
    sha256 "58d32c3f005f7791237916d1b5cd3a942115236155a0b7eba8bf36391d06eff7"
  end

  resource "fish_completions" do
    url "https://github.com/scalacenter/bloop/releases/download/v1.4.7/fish-completions"
    sha256 "a012a5cc76b57dbce17fad237f3b97bea6946ffc6ea0b61ac2281141038248dd"
  end

  def install
      mkdir "bin"
      mkdir "channel"

      mv "bloop-coursier.json", "channel/bloop.json"
      system "coursier", "install", "--install-dir", "bin", "--default-channels=false", "--channel", "channel", "bloop"

      resource("bash_completions").stage {
        mv "bash-completions", "bloop"
        bash_completion.install "bloop"
      }

      resource("zsh_completions").stage {
        mv "zsh-completions", "_bloop"
        zsh_completion.install "_bloop"
      }

      resource("fish_completions").stage {
        mv "fish-completions", "bloop.fish"
        fish_completion.install "bloop.fish"
      }

      prefix.install "bin"
  end

  test do
  end
end