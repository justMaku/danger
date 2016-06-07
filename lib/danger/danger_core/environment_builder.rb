require "danger/ci_source/ci_source"
require "danger/request_source/request_source"

module Danger
  class PullRequestEnvironment

    attr_accessor: pull_request, repository

    def initialize(local: false, existing_repo: true, dry_run: false)
      @pull_request = PullRequest.new
      @repository = Repository.new
    end

    def setup

    end

    def run

    end

  end

  class Repository
    attr_accessor: slug
    attr_accessor: origin
    attr_accessor: scm

    def self.new_with_existing_repository(directory: )
    end

    def self.new_with_temporary_directory
    end

    def initialize

    end

    def clone
      scm.exec("clone " + origin)
    end

    def create_branches(pull_request)
      scm.exec("branch #{EnvironmentManager.danger_base_branch} #{pull_request.base_commit}")
      scm.exec("branch #{EnvironmentManager.danger_head_branch} #{pull_request.head_commit}")
    end
  end

  class PullRequest
    attr_accessor: pull_request_id
    attr_accessor: repository
    attr_accessor: raw_pull_request

    attr_accessor: head_commit
    attr_accessor: base_commit

    attr_accessor: provider
    attr_accessor: ci_source

    def initialize(repository, pull_request_id: nil)
      @repository = repository
      @pull_request_id = pull_request_id
    end

    def detect_provider
      RequestSources::RequestSource.available_request_sources.each do |klass|
        request_provider = klass.new(self.ci_source, ENV)
        next unless request_provider.validates?
        self.provider = request_provider
      end
    end

    def fetch_information
      provider.fetch_pull_request
    end

    def update_with_results(results)
      provider.update_pull_request(results)
    end
  end
end