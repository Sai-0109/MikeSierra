using Microsoft.AspNetCore.Mvc;
using MikeSierra.Interface;
using MikeSierra.MikeSierra;
using MikeSierra.Models;

namespace MikeSierra.Controllers
{
    public class UserController : Controller
    {
        private readonly IUserRepository _userRepository; 

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }
        
        [HttpGet]
        public ActionResult Register()
        {
                return View();
        }

        [HttpPost]
        public ActionResult Register(User user ,IFormCollection formCollection)
        {
            user.Hobbies = new List<string>();

            string a = formCollection["Reading"];
            string b = formCollection["Writing"];
            string c = formCollection["Dancing"];

            if (a == "Reading")
                user.Hobbies.Add("Reading");

            if (b == "Writing")
                user.Hobbies.Add("Writing");

            if (c == "Dancing")
                user.Hobbies.Add("Dancing");

            if (user.FirstName != null)
            {
                string hobbies = string.Join(",", user.Hobbies);

                _userRepository.InsertUser(user.FirstName, user.LastName, user.Email, user.Password, user.Mobile, user.Gender, hobbies);

                string otp = GenerateRandomOTP();
               //  EmailService.SendOTP(user.Email, otp);

                    TempData["OTP"] = otp;
                Console.WriteLine("Otp:- ", TempData["OTP"]);

                return RedirectToAction("VerifyEmail", new { email = user.Email });
            }

            return View(user);
        }

        [HttpGet]
        public ActionResult VerifyEmail(string email)
        {
            ViewBag.Email = email;
            return View();
        }

        [HttpPost]
        public ActionResult VerifyEmail(string email, string otp)
        {
            string storedOTP = TempData["OTP"] as string;

            if (storedOTP != null && storedOTP.Equals(otp))
            {
                User user = _userRepository.GetUserDetails(email,otp);
                return View("VerifyEmailDetails", user);
            }

            ViewBag.ErrorMessage = "Invalid OTP";
            return View();
        }

        private string GenerateRandomOTP()
        {
            Random rand = new Random();
            return rand.Next(100000, 999999).ToString();
        }
        [HttpGet]
        public IActionResult GetUsesrDetails()
        {

            return View();  
        }


    }


}
