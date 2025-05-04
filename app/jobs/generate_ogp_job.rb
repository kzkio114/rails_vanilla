class GenerateOgpJob < ApplicationJob
  queue_as :default

  def perform(snake_id)
    system("bun run app/lib/tasks/generate_ogp_once.ts #{snake_id}")
  end
end
