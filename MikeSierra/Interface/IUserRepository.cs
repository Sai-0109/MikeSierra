using MikeSierra.Models;

namespace MikeSierra.Interface
{
    public interface IUserRepository
    {
        int InsertUser(string firstName, string lastName, string email, string password, string mobile, string gender, string hobbies);
        User GetUserByEmail(string email);
         User GetUserDetails(string email, string Otp);

      //  List<string> GetHobbies();
    }

}
