class TagBroadcastJob < ApplicationJob
  queue_as :default

  def perform(tag)
    # Do something later
    ActionCable.server.broadcast "tag_channel", tag_checkbox: render_tag_checkbox(tag), error_message: ''
  end

  private
  def render_tag_checkbox(tag)
    ApplicationController.renderer.render(partial: 'rooms/tag_form', locals: { tag: tag})
  end

end
