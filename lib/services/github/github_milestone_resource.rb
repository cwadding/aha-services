class GithubMilestoneResource < GithubResource
  def find_by_number(number)
    prepare_request
    response = http_get "#{github_milestones_path}/#{number}"
    found_resource(response)
  end

  def find_by_title(title)
    prepare_request
    response = http_get github_milestones_path
    process_response(response, 200) do |milestones|
      return milestones.find { |milestone| milestone['title'] == title }
    end
  end

  def create(new_milestone)
    prepare_request
    response = http_post github_milestones_path, new_milestone.to_json
    process_response(response, 201) do |milestone|
      return milestone
    end
  end

  def update(number, updated_milestone)
    prepare_request
    response = http_patch "#{github_milestones_path}/#{number}", updated_milestone.to_json
    process_response(response, 200) do |milestone|
      return milestone
    end
  end

private

  def github_milestones_path
    "#{@service.server_url}/repos/#{@service.data.repository}/milestones"
  end
end
