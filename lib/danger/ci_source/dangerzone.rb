module Danger
  module CISource
    class DangerZone < CI
      
      def supported_request_sources
        @supported_request_sources ||= [Danger::RequestSources::GitHub]
      end

      def self.validates?(env)
        return true unless env["DANGER_ZONE"].nil?
      end

      def initialize(_env)
        self.repo_slug = "justMaku/dangerzone"
        self.pull_request_id = "1"
      end
    end
  end
end
