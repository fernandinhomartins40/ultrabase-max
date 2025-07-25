import { useState, useEffect } from 'react'
import { ChevronDown, Plus, Settings, Users } from 'lucide-react'
import { useRouter } from 'next/router'
import { useQuery } from '@tanstack/react-query'
import { useProfile } from 'lib/profile'
import { TenantContextManager, ProjectInfo } from 'lib/ultrabase-tenant'
import { Button } from 'ui'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from 'ui'

interface ProjectSelectorProps {
  className?: string
}

export function ProjectSelector({ className }: ProjectSelectorProps) {
  const router = useRouter()
  const { profile } = useProfile()
  const tenantManager = TenantContextManager.getInstance()
  const [selectedProject, setSelectedProject] = useState<ProjectInfo | null>(null)

  // Fetch user's projects
  const { data: projects = [], isLoading } = useQuery(
    ['ultrabase-projects', profile?.id],
    async () => {
      if (!profile?.id) return []

      const response = await fetch('/api/ultrabase/projects')
      if (!response.ok) throw new Error('Failed to fetch projects')

      return response.json() as Promise<ProjectInfo[]>
    },
    {
      enabled: !!profile?.id,
      staleTime: 5 * 60 * 1000, // 5 minutes
    }
  )

  // Set initial project from URL or localStorage
  useEffect(() => {
    const projectRef = router.query.ref as string
    const savedProjectId = localStorage.getItem('ultrabase-selected-project')

    if (projectRef) {
      const project = projects.find((p) => p.slug === projectRef || p.id === projectRef)
      if (project) {
        setSelectedProject(project)
        tenantManager.setContext({
          projectId: project.id,
          organizationId: project.organizationId,
          userId: profile?.id || '',
          role: project.role,
        })
        localStorage.setItem('ultrabase-selected-project', project.id)
      }
    } else if (savedProjectId && projects.length > 0) {
      const project = projects.find((p) => p.id === savedProjectId)
      if (project) {
        setSelectedProject(project)
        tenantManager.setContext({
          projectId: project.id,
          organizationId: project.organizationId,
          userId: profile?.id || '',
          role: project.role,
        })
      }
    } else if (projects.length > 0) {
      // Select first project by default
      const project = projects[0]
      setSelectedProject(project)
      tenantManager.setContext({
        projectId: project.id,
        organizationId: project.organizationId,
        userId: profile?.id || '',
        role: project.role,
      })
      localStorage.setItem('ultrabase-selected-project', project.id)
    }
  }, [projects, router.query.ref, profile?.id])

  const handleProjectSelect = (project: ProjectInfo) => {
    setSelectedProject(project)
    tenantManager.setContext({
      projectId: project.id,
      organizationId: project.organizationId,
      userId: profile?.id || '',
      role: project.role,
    })
    localStorage.setItem('ultrabase-selected-project', project.id)

    // Navigate to project dashboard
    router.push(`/project/${project.slug}`)
  }

  const handleCreateProject = () => {
    router.push('/new/project')
  }

  const handleProjectSettings = (project: ProjectInfo) => {
    router.push(`/project/${project.slug}/settings`)
  }

  const handleOrganizationSettings = (project: ProjectInfo) => {
    router.push(`/org/${project.organizationId}/settings`)
  }

  if (isLoading) {
    return (
      <div className={className}>
        <Button variant="outline" disabled>
          <div className="animate-pulse bg-gray-200 h-4 w-32 rounded" />
          <ChevronDown className="ml-2 h-4 w-4" />
        </Button>
      </div>
    )
  }

  if (!selectedProject) {
    return (
      <div className={className}>
        <Button variant="outline" onClick={handleCreateProject}>
          <Plus className="mr-2 h-4 w-4" />
          Create Project
        </Button>
      </div>
    )
  }

  return (
    <div className={className}>
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="outline" className="w-full justify-between">
            <div className="flex items-center space-x-2">
              <div className="w-2 h-2 rounded-full bg-green-500" />
              <span className="font-medium">{selectedProject.name}</span>
              <span className="text-muted-foreground text-sm">
                {selectedProject.organizationName}
              </span>
            </div>
            <ChevronDown className="h-4 w-4 opacity-50" />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="start" className="w-80">
          <DropdownMenuLabel>Projects</DropdownMenuLabel>
          <DropdownMenuSeparator />

          {projects.map((project) => (
            <DropdownMenuItem
              key={project.id}
              onSelect={() => handleProjectSelect(project)}
              className="flex items-center justify-between"
            >
              <div>
                <div className="font-medium">{project.name}</div>
                <div className="text-sm text-muted-foreground">
                  {project.organizationName} • {project.role}
                </div>
              </div>
              {project.id === selectedProject.id && (
                <div className="w-2 h-2 rounded-full bg-green-500" />
              )}
            </DropdownMenuItem>
          ))}

          <DropdownMenuSeparator />

          <DropdownMenuItem onSelect={handleCreateProject}>
            <Plus className="mr-2 h-4 w-4" />
            Create New Project
          </DropdownMenuItem>

          {selectedProject && (
            <>
              <DropdownMenuSeparator />

              <DropdownMenuItem onSelect={() => handleProjectSettings(selectedProject)}>
                <Settings className="mr-2 h-4 w-4" />
                Project Settings
              </DropdownMenuItem>

              <DropdownMenuItem onSelect={() => handleOrganizationSettings(selectedProject)}>
                <Users className="mr-2 h-4 w-4" />
                Organization Settings
              </DropdownMenuItem>
            </>
          )}
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  )
}
