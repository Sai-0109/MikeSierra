using System.ComponentModel.DataAnnotations;

namespace MikeSierra.Models
{
    public class User
    {
        public int Id { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        [RegularExpression(@"^\d{10}$", ErrorMessage = "Invalid Mobile Number")]
        public string Mobile { get; set; }

        [Required]
        public string Gender { get; set; }

        [Required]
        public string OTP { get; set; }


       
        public List<string> Hobbies { get; set; } 
    }

}
