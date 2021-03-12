
def index
  @users = User.order(id: :desc).page(params[:page]).per(25)
end

def show
  @category = Category.find(params[:id])
end


def create

end
