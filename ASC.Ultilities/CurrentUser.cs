﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASC.Ultilities
{
    public class CurrentUser
    {
        public string Name { get; set; }

        public string Email { get; set; }

        public bool IsActive { get; set; }

        public string[] Roles { get; set; }
    }
}
