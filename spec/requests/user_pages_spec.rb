require 'spec_helper'

describe "User pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  describe "profile page" do

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_content('Login to your account') }
    it { should have_title(full_title('Sign in')) }
  end

  describe "signin" do
    before do
      visit new_user_session_path
      fill_in "E-Mail", with: user.email
      fill_in "Password", with: user.password
      click_button "Login"
    end

    it { should have_content('Dashboard') }
    it { should have_title(full_title('Dashboard')) }
  end

  describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit new_user_path }

    let(:submit) { "Sign Up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "E-Mail", with: "new@email.com"
        fill_in "Password", with: "foobar"
        fill_in "Re-type Your Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'new@email.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "edit" do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      # TODO Customize the permitted parameters in the future
      #   let(:params) do
      #     { user: { admin: true, password: user.password,
      #               password_confirmation: user.password } }
      #   end
      #   before do
      #     sign_in user, no_capybara: true
      #     patch user_path(user), params
      #   end
      #   specify { expect(user.reload).not_to be_admin }
      # end
    end

  end

  describe "Tasks" do

    before do
      sign_in user
      visit authenticated_root_path
    end
    describe "task creation" do

      describe "with invalid information" do
        it "should not create the task" do
          expect { click_link 'Create New Task' }.not_to change(Task, :count)
        end

        describe "to have error message" do
          before { click_link('Create New Task') }

          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in 'Name', with: "bla bla bla"
          fill_in 'Due Date', with: Date.tomorrow
        end

        it "should create a new Task" do
          expect { click_link 'Create New Task' }.to change(Task, :count).by(1)
        end

        describe "should have success message" do
          before { click_link('Create New Task') }

          it { should have_content('success')}

        end
      end
    end


    describe "mark as completed" do
      let(:first_task) { user.pending_tasks.first }

      specify do
        expect do
          check("task-#{first_task.id}")
        end.to change(user.done_tasks, :count).by(1)
      end
    end

    describe "mark as incompleted" do
      let(:first_task) { user.done_tasks.first }

      specify do
        expect do
          uncheck("task-#{first_task.id}")
        end.to change(user.pending_tasks, :count).by(1)
      end
    end

    describe "edit" do
      let(:first_task) { user.tasks.first }
      before do
        click_link("edit-task-#{first_task.id}")
      end

      describe "with invalid information" do
        before { click_button('Save') }

        it { should have_content('error') }
      end

      describe "with valid information" do
        let(:new_name) { "New Task Name" }
        let(:new_due_date) { Date.tomorrow }

        before do
          fill_in "Name", with: new_name
          fill_in "Due Date", with: new_due_date
          click_button "Save"
        end

        specify { expect(first_task.reload.name).to eq new_name }
        specify { expect(first_task.reload.due_in).to eq new_due_date }
      end

    end

    describe "delete" do
      let(:tasks_count) { user.tasks.count }
      before do
        first_task = user.tasks.first
        click_link("delete-task-#{first_task.id}")
      end

      it { should change(Task, :count). by(1) }
      it { should_not have_link("delete-task-#{first_task.id}") }

      describe "should change the tasks count" do
        before { tasks_count -= 1 }

        it { should have_css('#all-tasks-count', text: tasks_count) }
      end
    end

    describe "show the tasks count" do
      let(:all_tasks) { user.tasks.count }
      let(:pending_tasks) { user.pending_tasks.count }
      let(:done_tasks) { user.done_tasks.count }
      let(:overdue_tasks) { user.overdue_tasks.count }

      it { should have_css('#all-tasks-count', text: all_tasks) }
      it { should have_css('#pending-tasks-count', text: pending_tasks) }
      it { should have_css('#done-tasks-count', text: done_tasks) }
      it { should have_css('#overdue-tasks-count', text: overdue_tasks) }
    end

    describe "show the due date" do
      let(:first_due_task) { user.tasks.where.not(due_in: nil).first }

      subject { find('.task-bell.tooltips:first-child')['data-original-title'] }

      it { should eq first_due_task }

    end

  end

end

