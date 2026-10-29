import { Routes, Route, useLocation } from "react-router-dom";
import { ThemeProvider } from "./contexts/ThemeContext";
import { Navbar } from "./components/Navbar";
import { Footer } from "./components/Footer";

import { Homepage } from "./pages/Homepage";
import { AboutPage } from "./pages/AboutPage";
import { AcademicWorkPage } from "./pages/AcademicWorkPage";
import { SubjectPage } from "./pages/SubjectPage";
import { CoursePage } from "./pages/CoursePage";
import { SettingsPage } from "./pages/SettingsPage";
import { ActivitiesPage } from "./pages/ActivitiesPage";
import { ActivityPage } from "./pages/ActivityPage";
import { ContactPage } from "./pages/ContactPage";


import { Cisp300 } from "./courses/cisp300/Cisp300";
import { Cisp310 } from "./courses/cisp310/Cisp310";
import { Cisp360 } from "./courses/cisp360/Cisp360";

function AppShell() {
  const location = useLocation();

  // Disable background only on Settings page
  const noBackground = location.pathname.startsWith("/settings");

  return (
    <div
      className={`min-h-screen flex flex-col ${
        noBackground ? "" : "app-background"
      }`}
    >
      <Navbar />
      <main className="flex-1">
        <Routes>
          <Route path="/" element={<Homepage />} />
          <Route path="/about" element={<AboutPage />} />
          <Route path="/academic-work" element={<AcademicWorkPage />} />
          <Route path="/subject/:subjectId" element={<SubjectPage />} />
          <Route path="/course/cisp300" element={<Cisp300 />} />
          <Route path="/course/cisp300/assignment/:assignmentSlug" element={<Cisp300 />} />
          <Route path="/course/cisp310" element={<Cisp310 />} />
          <Route path="/course/cisp310/assignment/:assignmentSlug" element={<Cisp310 />} />
          <Route path="/course/cisp360" element={<Cisp360 />} />
          <Route path="/course/cisp360/assignment/:assignmentSlug" element={<Cisp360 />} />
          <Route path="/course/:courseId" element={<CoursePage />} />
          <Route path="/activities" element={<ActivitiesPage />} />
          <Route path="/activities/:activityId" element={<ActivityPage />} />
          <Route path="/contact" element={<ContactPage />} />
          <Route path="/settings" element={<SettingsPage />} />
        </Routes>
      </main>
      <Footer />
    </div>
  );
}

export default function App() {
  return (
    <ThemeProvider>
        <AppShell />
    </ThemeProvider>
  );
}
