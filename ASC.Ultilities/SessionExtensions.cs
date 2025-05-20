using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace ASC.Ultilities
{
    public static class SessionExtensions
    {
        public static void SetSession(this ISession sesssion, string key, object value)
        {
            sesssion.Set(key, Encoding.ASCII.GetBytes(JsonConvert.SerializeObject(value)));
        }

        public static T GetSession<T>(this ISession session, string key)
        {
            byte[] value;
            if (session.TryGetValue(key, out value))
            {
                return JsonConvert.DeserializeObject<T>(Encoding.ASCII.GetString(value));
            }
            else
            {
                return default(T);
            }
        }
    }
}
