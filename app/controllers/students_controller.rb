class StudentsController < ApplicationController

    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student
        else
            render json: { errors: ["Student not found"] }, status: :not_found
        end
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :created
        else
            render json: { errors: ["Please enter valid data"] }, status: :unprocessable_entity
        end
    end

    def update
        student = Student.find_by(id: params[:id])
        student.update(student_params)
    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            head :no_content
        else
            render json:  { errors: ["Student not found"] }, status: :not_found
        end
    end



    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

end
