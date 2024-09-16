class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :knowledge_area, :attachment_url

  def attachment_url
    object.attachment.attached? ? object.attachment.filename.to_s : nil
  end
end
