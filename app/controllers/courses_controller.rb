class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  # GET /courses/storage_usage
  def storage_usage
    begin
      s3 = Aws::S3::Client.new(region: ENV['AWS_REGION'])
      bucket_name = ENV['AWS_BUCKET']
      objects = s3.list_objects_v2(bucket: bucket_name)
      total_bytes = objects.contents.sum(&:size)
      total_gb = total_bytes.to_f / (1024 * 1024 * 1024)
      render json: {
        storage_used: total_gb.round(2)
      }
    rescue Aws::S3::Errors::ServiceError => e
      render json: { error: e.message }
    end
    
    
  end

  # GET /courses
  def index
    @courses = Course.order(created_at: :desc)
    render json: @courses, each_serializer: CourseSerializer
  end

  # GET /courses/1
  def show
    render json: @course, serializer: CourseSerializer
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, serializer: CourseSerializer, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: @course, serializer: CourseSerializer
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy!
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :start_date, :end_date, :knowledge_area, :attachment, :description)
    end
end
