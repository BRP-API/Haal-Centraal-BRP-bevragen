using BrpProxy.Middlewares;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;

var builder = WebApplication.CreateBuilder(args);

var a = Path.Combine("configuration", "ocelot.json");
builder.Configuration.AddJsonFile(Path.Combine("configuration", "ocelot.json"));

// Add services to the container.
builder.Services.AddOcelot();

//builder.Services.AddControllers();

var app = builder.Build();

// Configure the HTTP request pipeline.

//app.UseHttpsRedirection();

//app.UseAuthorization();

//app.MapControllers();

app.UseMiddleware<OverwriteResponseBodyMiddleware>();
app.UseOcelot().Wait();

app.Run();
