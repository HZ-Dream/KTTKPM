﻿using ASCWeb.Configuration;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace ASCWeb.Controllers
{
    public class DashboardController : BaseController
    {
        private IOptions<ApplicationSettings> _settings;

        public DashboardController(IOptions<ApplicationSettings> settings) 

        {
            _settings = settings;
        }

        public IActionResult Dashboard()
        {
            return View();
        }
    }
}
