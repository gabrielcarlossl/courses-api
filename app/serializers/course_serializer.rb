class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :knowledge_area, :attachment_url, :description

  def attachment_url
    if object.attachment.attached?
      object.attachment.blob.key.split('/').last
    else
      nil
    end
  end
end
