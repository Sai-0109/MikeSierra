using MikeSierra.Models;
using System.Data;
using System.Data.SqlClient;
using System.Reflection.PortableExecutable;

namespace MikeSierra.Interface
{
    public class UserRepository : IUserRepository
    {
        private readonly string _connectionString= "server=.\\SQLEXPRESS;database=MikeSierra;integrated security=true;"; 
        
        public int InsertUser(string firstName, string lastName, string email, string password, string mobile, string gender, string hobbies)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("usp_InsertUser", connection))
                {
                    try
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@FirstName", firstName);
                        command.Parameters.AddWithValue("@LastName", lastName);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Password", password);
                        command.Parameters.AddWithValue("@Mobile", mobile);
                        command.Parameters.AddWithValue("@Gender", gender);
                        command.Parameters.AddWithValue("@Hobbies", hobbies);

                        // Add any additional parameters if required by the stored procedure
                        command.ExecuteReader();
                        return 1;
                        
                    }
                    catch (Exception ex) 
                    {
                        Console.WriteLine(ex.Message);
                        Console.WriteLine(ex.StackTrace);
                        Console.WriteLine(ex.InnerException);

                        return (int)command.ExecuteScalar(); 
                    }
                   
                }
            }
        }
        //public int GetUserDetails(string email, string  Otp)
        //{
        //    using (SqlConnection connection = new SqlConnection(_connectionString))
        //    {
        //        connection.Open();

        //        using (SqlCommand command = new SqlCommand("Ups_GetUSers", connection))
        //        {
        //            try
        //            {
        //                command.CommandType = CommandType.StoredProcedure;

        //                command.Parameters.AddWithValue("@Email", email);
        //                command.Parameters.AddWithValue("@Otp",Otp);

        //                command.ExecuteReader();
        //                return 1;

        //            }
        //            catch (Exception ex)
        //            {
        //                Console.WriteLine(ex.Message);
        //                Console.WriteLine(ex.StackTrace);
        //                Console.WriteLine(ex.InnerException);

        //                return (int)command.ExecuteScalar();
        //            }

        //        }
        //    }
        //}

        public User GetUserDetails(string email, string Otp)

        {
            User user= new User();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("GetUserByEmail", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Email", email);

                    SqlDataReader reader = command.ExecuteReader();
                    Console.WriteLine(reader.ToString());
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            user = new User
                            {
                                Id = (int)reader["UserID"],
                                FirstName = reader["FirstName"].ToString(),
                                LastName = reader["LastName"].ToString(),
                                Email = reader["Email"].ToString(),
                                Password = reader["Password"].ToString(),
                                Mobile = reader["Mobile"].ToString(),
                                Gender = reader["Gender"].ToString(),
                                Hobbies = reader["Hobbies"].ToString().Split(',').ToList()
                            };
                          
                        }
                    } 
                       
                    
                }

                return user;
            }
        }

        User IUserRepository.GetUserByEmail(string email)
        {
            throw new NotImplementedException();
        }

     

        //public List<string> GetHobbies()
        //{
        //    throw new NotImplementedException();
        //}

        //public List<string> GetHobbies()
        //{
        //    List<string> hobbies = new List<string>();

        //    using (SqlConnection connection = new SqlConnection(_connectionString))
        //    {
        //        connection.Open();

        //        using (SqlCommand command = new SqlCommand("Usp_GetHobbies", connection))
        //        {

        //            command.CommandType = CommandType.StoredProcedure;
        //            command.Parameters.AddWithValue("@Email", email);

        //            using (SqlDataReader reader = command.ExecuteReader())
        //            {
        //                if (reader.Read())
        //                {
        //                    return new User
        //                    {
        //                        Id = (int)reader["Id"],
        //                        FirstName = reader["FirstName"].ToString(),
        //                        LastName = reader["LastName"].ToString(),
        //                        Email = reader["Email"].ToString(),
        //                        Password = reader["Password"].ToString(),
        //                        Mobile = reader["Mobile"].ToString(),
        //                        Gender = reader["Gender"].ToString(),
        //                        Hobbies = reader["Hobbies"].ToString().Split(',').ToList()
        //                    };
        //                }
        //            }
        //        }


        //    }




        //    return hobbies;
        //}
    }

}
