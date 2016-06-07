module Danger
  class Local < Runner
    self.summary = 'Run the Dangerfile locally.'
    self.command = 'exp'

    def initialize(argv)
      @dangerfile_path = "Dangerfile" if File.exist? "Dangerfile"
      super
    end

    def validate!
      super
      unless @dangerfile_path
        help! "Could not find a Dangerfile."
      end
    end

    def run
      prenv = PullRequestEnvironment()
    end
  end
end
