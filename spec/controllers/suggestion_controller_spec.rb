describe SuggestionController do
  let(:assignment) do
    build(:assignment, id: 1, name: 'test assignment', instructor_id: 6, staggered_deadline: true, directory_path: 'same path',
          participants: [build(:participant)], teams: [build(:assignment_team)], course_id: 1, allow_suggestions: 1)
  end
  let(:assignment_form) { double('AssignmentForm', assignment: assignment) }
  let(:admin) { build(:admin) }
  let(:instructor) { build(:instructor, id: 6) }
  let(:instructor2) { build(:instructor, id: 66) }
  let(:ta) { build(:teaching_assistant, id: 8) }
  let(:student) { build(:student, id: 1)}
  let(:questionnaire) { build(:questionnaire, id: 666) }
  let(:suggestion){build(:suggestion)}
  let(:assignment_questionnaire) { build(:assignment_questionnaire, id: 1, questionnaire: questionnaire) }

  before(:each) do
    allow(Suggestion).to receive(:find).with('1').and_return(suggestion)
    stub_current_user(student, student.role.name, student.role)
  end

  describe '#student_view' do
    it 'renders suggestions#student_view' do
      get :student_view, id: 1
      expect(response).to render_template(:student_view)
    end
  end

  describe '#student_edit' do
      it 'renders suggestions#student_edit' do
        get :student_edit, id: 1
        expect(response).to render_template(:student_edit)
      end
  end

  describe '#update_suggestion' do
    it "checks updated is saved" do
      params = {title:"new title", description: "new description", signup_preference:"N"}
      session = {student: 1}
      post :update, params, session
      expect(response).to render_template('suggestion/new?id=1')
    end
  end
end